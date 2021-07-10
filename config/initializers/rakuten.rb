RakutenWebService.configure do |c|
    # (必須) アプリケーションID
  c.application_id = ENV['RAKUTEN_APP_ID']
  c.affiliate_id = ENV['RAKUTEN_APP_AFFILIATE'] # default: nil
end
