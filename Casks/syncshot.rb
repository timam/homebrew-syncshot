cask "syncshot" do
  version "0.1.15"
  sha256 "1baf4f01bc0fedeb8ebd73e42b43571ff03ec5d8899c88d5c1f5297862460a8b"

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
