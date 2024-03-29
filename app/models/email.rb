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

  def create_signature
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page = agent.get "http://crypto-book.com/emailer/getimgurl.php?token=" + self.signature.to_s + ' ,'
    text = "http://crypto-book.com/emailer/" + page.title
    return text
  end

  def view_signature
    text = "http://crypto-book.com/emailer/viewimg.php?filename=" + self.url.sub("http://crypto-book.com/emailer/", "")
    return text
  end

  def get_read
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page = agent.get "http://crypto-book.com/emailer/read.php?filename=" + self.url.sub("http://crypto-book.com/emailer/", "")
    text = page.title
    if (text == "read")
      return true
    else
      return false
    end
  end

  def get_read_time
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page = agent.get "http://crypto-book.com/emailer/timeaccessed.php?filename=" + self.url.sub("http://crypto-book.com/emailer/", "")
    text = page.title
    text = text.sub(".", "")
    return text
  end
end
