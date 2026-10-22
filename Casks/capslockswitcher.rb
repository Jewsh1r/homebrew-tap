cask "capslockswitcher" do
  version "2.0.0"
  sha256 "93c42ade6e74a924440e1fc11a804e3406b29d1fd1fda8d4e8260e3a5f0eaccb"

  url "https://github.com/Jewsh1r/CapsLockSwitcher/releases/download/v#{version}/CapsLockSwitcher.app.zip"
  name "CapsLockSwitcher"
  desc "Switch between two keyboard layouts using the Caps Lock key"
  homepage "https://github.com/Jewsh1r/CapsLockSwitcher"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "CapsLockSwitcher.app"

  postflight_steps do
    # The release is ad-hoc signed, not notarized.
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/CapsLockSwitcher.app"]
  end

  uninstall quit: "com.doasync.CapsLockSwitcher"

  zap trash: [
    "~/Library/Containers/com.doasync.CapsLockSwitcher",
    "~/Library/Preferences/com.doasync.CapsLockSwitcher.plist",
  ]

  caveats do
    <<~EOS
      CapsLockSwitcher requires macOS 15.2 or later and needs no permissions.
      After launching the app, select two input sources in its menu bar menu.
      Caps Lock switches layouts; hold it, or press Shift+Caps Lock or
      Command+Caps Lock, for uppercase. Caps Lock again turns uppercase off.
    EOS
  end
end
