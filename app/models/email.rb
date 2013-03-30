class Email < ActiveRecord::Base
  attr_accessible :read, :url, :body
  belongs_to :user

  require 'fileutils'
  require 'mechanize'
  require 'logger'

  def gen_url
  	genurl = Time.now.to_f.to_s + rand(1000).to_s
  	genurl = genurl.sub!('.', '')

  	return genurl
  end

#  def copyimage
#  	FileUtils.cp('app/assets/images/rails.png', 'app/assets/images/urls/' + self.url.to_s + '.png')
#  end

# def getURL
# 	return 'app/assets/images/urls/' + self.url.to_s + '.png'
# end

#  def checkRead
#  	created = File.ctime(getURL)
#  	accessed = File.atime(getURL)
#  	if(accessed - created > 10)
#  	  return true
#  	else
#  	  return false
#    end
#  end

#  def mailtolink
#    image = getURL
#    return 'http://localhost:3000/assets/urls/' + self.url.to_s + '.png'
#  end

  def getimageurl
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'

    page = agent.get "http://google.com" + self.url
    text = page.title
    return text;
  end

end
