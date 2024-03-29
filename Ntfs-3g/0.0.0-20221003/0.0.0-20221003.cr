class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--with-fuse=internal",
                            "--docdir=/usr/share/doc/ntfs-3g-2022.10.3"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def install
        super
        makeLink("../bin/ntfs-3g","#{Ism.settings.rootPath}usr/sbin/mount.ntfs",:symbolicLink)
        makeLink("ntfs-3g.8","#{Ism.settings.rootPath}usr/share/man/man8/mount.ntfs.8",:symbolicLink)
    end

end
