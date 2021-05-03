# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Annict <no-reply@annict.com>"
  layout "mailer"
end
