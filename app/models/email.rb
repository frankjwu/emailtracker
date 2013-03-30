class Email < ActiveRecord::Base
  attr_accessible :read, :url, :body
  belongs_to :user

  require 'fileutils'
  require 'RMagick'

  def gen_url
  	genurl = Time.now.to_f.to_s + rand(1000).to_s
  	genurl = genurl.sub!('.', '')

  	return genurl
  end

  def createimage
  	img = Magick::ImageList.new('app/assets/images/white.jpg')

		txt = Magick::Draw.new

		txt.annotate(img, 0,0,0,0, "Mike Wu") {
			self.gravity = Magick::SouthGravity
			self.pointsize = 25
			self.stroke = '#000000'
			self.fill = '#ffffff'
			self.font_weight = Magick::BoldWeight
		}

		img.write('text.jpg')
  end

  def copyimage
  	FileUtils.cp('app/assets/images/rails.png', 'app/assets/images/urls/' + self.url.to_s + '.png')
  end

  def getURL
  	return 'app/assets/images/urls/' + self.url.to_s + '.png'
  end

  def checkRead
  	created = File.ctime(getURL)
  	accessed = File.atime(getURL)
  	if(accessed - created > 10)
  	  return true
  	else
  	  return false
    end
  end

  def mailtolink
    image = getURL
    return 'http://localhost:3000/assets/urls/' + self.url.to_s + '.png'
  end

end
