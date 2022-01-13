class HazelcastEnterpriseAT51Snapshot < Formula
    desc "Tool to run Hazelcast IMDG member instances locally"
    homepage "https://github.com/hazelcast/hazelcast-command-line"
    url "https://repository.hazelcast.com/snapshot/com/hazelcast/hazelcast-enterprise-distribution/5.1-SNAPSHOT/hazelcast-enterprise-distribution-5.1-20220113.112751-284.tar.gz"
    sha256 "f955265618a857c8efa5ad4c7bf5656ae84d1b8d209cf0a42b1aeb56ae368140"
    conflicts_with "hazelcast"
  
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
  