def default_value(val, default)
  if val.nil?
    return default
  end
  if val === 'true'
    return true
  elsif val === 'false'
    return false
  elsif val.is_a? Numeric
    return BigDecimal.new(val).to_i
  else
    return val
  end
end

gitConfig = {
  :name => ENV['git_name'],
  :email => ENV['git_email'],
  :sslVerify => default_value(ENV['git_ssl_verify'], true)
}

template '/home/devenv/.gitconfig' do
  source '.gitconfig.erb'
  user 'devenv'
  group 'devenv'
  variables ({ :confvars => gitConfig })
end
