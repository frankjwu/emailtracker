class Email < ActiveRecord::Base
  attr_accessible :read, :url
  belongs_to :user

  require 'fileutils'

  def gen_url
  	genurl = Time.now.to_f.to_s + rand(1000).to_s
  	genurl = genurl.sub!('.', '')

  	return genurl
  end

  def copyimage
  	FileUtils.cp('app/assets/images/rails.png', 'app/assets/images/urls/' + self.url.to_s + '.png')
  end

end
