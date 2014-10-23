require 'bundler/setup'
Bundler.require(:default)

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
Braintree::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']

app =  Proc.new do |env|
  if env['REQUEST_METHOD'] == 'POST'
    [ '200', {'Content-Type' => 'application/json'}, ["{ \"clientToken\": \"#{Braintree::ClientToken.generate}\" }"] ]
  else
    [ '200', {'Content-Type' => 'text/html'}, File.readlines('index.html') ]
  end
end

run app
