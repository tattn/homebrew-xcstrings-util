class XcstringsUtil < Formula
  desc "Agent-friendly CLI for Xcode string catalogs"
  homepage "https://github.com/tattn/xcstrings-util"
  version "0.0.1"


  on_macos do
    on_arm do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.1/xcstrings-util-0.0.1-macos-arm64.tar.gz"
      sha256 "0a293bac0dd60ea5b1a2f142a95e2edabd6277204ba27d3fbdd6c291112afa56"
    end

    on_intel do
      url "https://github.com/tattn/xcstrings-util/releases/download/0.0.1/xcstrings-util-0.0.1-macos-x86_64.tar.gz"
      sha256 "a546ff91f00aaecbe4b410dea5223344753e653b0a9df426bc770a52bd8a0de6"
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
