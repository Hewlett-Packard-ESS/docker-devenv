def default_value(val, default)
  if val.nil?
    return default
  end
  if val.is_a? Numeric
    return BigDecimal.new(val).to_i
  elsif val.downcase === 'true'
    return true
  elsif val.downcase === 'false'
    return false
  else
    return val
  end
end


gitConfig = {
  :name => ENV['git_name'],
  :email => ENV['git_email'],
  :sslVerify => default_value(ENV['git_ssl_verify'], true)
}

template '/home/hpess/.gitconfig' do
  source '.gitconfig.erb'
  user 'hpess'
  group 'hpess'
  variables ({ :confvars => gitConfig })
end
