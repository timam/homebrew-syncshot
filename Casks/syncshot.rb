cask "syncshot" do
  version "0.1.45"
  sha256 "d7e92002dfbbd9f05c628a83e4b03b4b6158b4c75ba65d927a5de70e87be63d9"

  url "https://github.com/timam/syncshot-releases/releases/download/v#{version}/SyncShot.dmg"
  name "SyncShot"
  desc "Offload and backup utility for creatives"
  homepage "https://syncshot.io"

  depends_on macos: ">= :ventura"

  app "SyncShot.app"

  # SyncShot is ad-hoc signed (not notarized) during beta. Homebrew applies
  # the quarantine xattr by default, which triggers Gatekeeper's
  # "Apple could not verify" dialog on first launch. Strip it after install
  # so the app opens cleanly.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SyncShot.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/SyncShot",
    "~/Library/Preferences/com.syncshot.app.plist",
    "~/Library/Caches/com.syncshot.app",
  ]
end
