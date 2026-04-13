class XcstringsUtil < Formula
  desc "Agent-friendly CLI for Xcode string catalogs"
  homepage "https://github.com/tattn/xcstrings-util"
  version "0.0.3"


  on_macos do
    on_arm do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.3/xcstrings-util-0.0.3-macos-arm64.tar.gz"
      sha256 "21353d5c0fc9030e4024a9554beef0746143a67ce5c44b66ab022d0f53145737"
    end

    on_intel do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.3/xcstrings-util-0.0.3-macos-x86_64.tar.gz"
      sha256 "3a05c1089a6588edf34f1755dbfe50250ca3296e8078665563104b3ce156cd79"
    end
  end

  def install
    bin.install "xcstrings-util"
  end

  test do
    sample = testpath/"Sample.xcstrings"
    sample.write <<~JSON
      {
        "sourceLanguage" : "en",
        "strings" : {
          "title" : {
            "extractionState" : "manual",
            "localizations" : {
              "en" : {
                "stringUnit" : {
                  "state" : "translated",
                  "value" : "Title"
                }
              }
            }
          }
        },
        "version" : "1.0"
      }
    JSON

    output = shell_output("#{bin}/xcstrings-util locales #{sample} --json")
    assert_match "\"sourceLanguage\" : \"en\"", output
    assert_match "\"locales\" : [", output
    assert_match "\"en\"", output
  end
end
