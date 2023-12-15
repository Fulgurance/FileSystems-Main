class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-elf-shlibs",
                            "--disable-libblkid",
                            "--disable-libuuid",
                            "--disable-uuidd",
                            "--disable-fsck"],
                            buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        runGunzipCommand(["libext2fs.info.gz"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/info/")

        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libcom_err.a")
        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libe2p.a")
        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libext2fs.a")
        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libss.a")
    end

    def install
        super

        runInstallInfoCommand([ "--dir-file=/usr/share/info/dir",
                                "/usr/share/info/libext2fs.info"])
    end

end
