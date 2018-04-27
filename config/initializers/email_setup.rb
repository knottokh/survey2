if Rails.env.development?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 587,
        :domain => "survey2-knottoc9.c9users.io",
        :user_name => "merm.cu@gmail.com",
        :password => "merm11111",
        :authentication => "plain",
        :enable_starttls_auto => true
   }

elsif Rails.env.production?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 465,
        :domain => "128.199.222.219",
        :user_name => "merm.cu@mermthai.com",
        :password => "",
        :authentication => "plain",
        :ssl                  => true,
        :tls                  => true,
        :enable_starttls_auto => true
   }

end