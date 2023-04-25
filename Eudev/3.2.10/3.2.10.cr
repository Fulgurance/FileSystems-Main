class Target < ISM::Software

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--bindir=/usr/sbin",
                            "--sysconfdir=/etc",
                            "--enable-manpages",
                            "--disable-static"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        if option("Openrc")
            prepareOpenrcServiceInstallation("#{workDirectoryPath(false)}/udev-postmount","udev-postmount")
        end
    end

    def install
        super

        runUdevadmCommand(["hwdb","--update"])
    end

end
