cask "visual-studio-code-insiders" do
  arch = Hardware::CPU.intel? ? "darwin" : "darwin-arm64"

  version "1.63.0,8c56f0cae849839138fbd83fe4d5c7219c7ff806"

  if Hardware::CPU.intel?
    sha256 "37515869ac3794b08f313db95648b3f378bf278840ada9b94e38112532536d70"
  else
    sha256 "4b29e05f8ffe4164dfd1af9b7d01c3a8fef52e2a56938c242ca2fe5531b0b990"
  end

  url "https://az764295.vo.msecnd.net/insider/#{version.after_comma}/VSCode-#{arch}.zip",
      verified: "az764295.vo.msecnd.net/insider/"
  name "Microsoft Visual Studio Code"
  name "Visual Studio Code Insiders"
  desc "Code editor"
  homepage "https://code.visualstudio.com/insiders"

  livecheck do
    url "https://update.code.visualstudio.com/api/update/#{arch}/insider/VERSION"
    strategy :page_match do |page|
      name = page[/"name":"(\d+(?:\.\d+)+)/i, 1]
      version = page[/"version":"(\w+)/i, 1]
      next if name.blank? || version.blank?

      "#{name},#{version}"
    end
  end

  auto_updates true

  app "Visual Studio Code - Insiders.app"
  binary "#{appdir}/Visual Studio Code - Insiders.app/Contents/Resources/app/bin/code", target: "code-insiders"

  zap trash: [
    "~/Library/Application Support/Code - Insiders",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.vscodeinsiders.sfl*",
    "~/Library/Caches/Code - Insiders",
    "~/Library/Caches/com.microsoft.VSCodeInsiders",
    "~/Library/Caches/com.microsoft.VSCodeInsiders.ShipIt",
    "~/Library/Preferences/com.microsoft.VSCodeInsiders.helper.plist",
    "~/Library/Preferences/com.microsoft.VSCodeInsiders.plist",
    "~/Library/Saved Application State/com.microsoft.VSCodeInsiders.savedState",
    "~/.vscode-insiders",
  ]
end
