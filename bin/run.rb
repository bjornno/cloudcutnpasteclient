require 'rest-client'

def pasteFromClipBoard
  Java::JavaAwt::Toolkit.default_toolkit.system_clipboard.get_data(Java::JavaAwtDatatransfer::DataFlavor.stringFlavor)
end
def copyToClipboard(text)
  Java::JavaAwt::Toolkit.default_toolkit.system_clipboard.set_contents(Java::JavaAwtDatatransfer::StringSelection.new(text), nil)
end
if (ARGV[2] == "copy")
	buf = pasteFromClipBoard
	RestClient.put("https://cloudcutnpaste.herokuapp.com/#{buf}", {})
elsif (ARGV[2] == "paste")
	getbuf = RestClient.get("https://cloudcutnpaste.herokuapp.com/")
	copyToClipboard(getbuf)
end
