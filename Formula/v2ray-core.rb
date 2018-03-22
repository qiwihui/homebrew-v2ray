class V2rayCore < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://www.v2ray.com/"
  version "v3.14"
  url "https://github.com/v2ray/v2ray-core/releases/download/#{version}/v2ray-macos.zip"
  sha256 "8ac788cab01289ebf964c724d35eeb9c458a370e204956cf1a2ca3f5c433e961"

  def install
    bin.install "v2ray"
    bin.install "v2ctl"
    bin.install "geosite.dat"
    bin.install "geoip.dat"
    etc.install "config.json"
  end

  plist_options :manual => "v2ray -config=#{HOMEBREW_PREFIX}/etc/v2ray.config.json"

  def plist; <<~EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/v2ray</string>
        <string>-config</string>
        <string>#{etc}/v2ray.config.json</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
  </plist>
  EOS
end
  
  test do
    system "#{bin}/v2ray", "-version"
  end
end
