class HazelcastAT51Dr5 < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://repository.hazelcast.com/devel/com/hazelcast/hazelcast-distribution/5.1-DR5/hazelcast-distribution-5.1-DR5.tar.gz"
    sha256 "76acae268a561c45de2f4a506814176b990f4f26dcdee7999f66d413d3832bb9"
    conflicts_with "hazelcast-enterprise"
  
    depends_on "openjdk" => :recommended
  
    def install
      libexec.install Dir["*"]
      Dir["#{libexec}/bin/hz*"].each do |path|
        executable_name = File.basename(path)
        if executable_name.end_with? ".bat"
          next
        end
        (bin/executable_name).write_env_script libexec/"bin/#{executable_name}", Language::Java.overridable_java_home_env
      end
      prefix.install_metafiles
      inreplace libexec/"lib/hazelcast-download.properties", "hazelcastDownloadId=distribution", "hazelcastDownloadId=brew"
    end
  
    def post_install
      # TODO fix once we have hz command in main distro
      exec "echo Hazelcast installed"
    end
  
  end
  