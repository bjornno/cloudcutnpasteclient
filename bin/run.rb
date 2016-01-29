require 'rest-client'
require 'digest/md5'

def pasteFromClipBoard
  Java::JavaAwt::Toolkit.default_toolkit.system_clipboard.get_data(Java::JavaAwtDatatransfer::DataFlavor.stringFlavor)
end
def copyToClipboard(text)
  Java::JavaAwt::Toolkit.default_toolkit.system_clipboard.set_contents(Java::JavaAwtDatatransfer::StringSelection.new(text), nil)
end
org = JSON.parse(RestClient.get('http://ipinfo.io'), symbolize_names: true)[:org]
org_hash = Digest::MD5.hexdigest(org)
if (ARGV[2] == "copy")
	buf = pasteFromClipBoard
	RestClient.put("https://cloudcutnpaste.herokuapp.com/#{org_hash}/#{buf}", {})
elsif (ARGV[2] == "paste")
	getbuf = RestClient.get("https://cloudcutnpaste.herokuapp.com/#{org_hash}/")
	copyToClipboard(getbuf)
end
