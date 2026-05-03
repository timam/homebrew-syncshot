cask "syncshot" do
  version "0.1.44"
  sha256 "53d854c04fe060bfed33b52c976e22c8161d9ec5c5cfce20acd6f2ffd8f86f1e"

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
