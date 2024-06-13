class Target < ISM::Software

    def configure
        super

        configureSource(arguments:  "--prefix=/usr          \
                                    --disable-static        \
                                    --with-fuse=internal    \
                                    --docdir=/usr/share/doc/ntfs-3g-2022.10.3",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        makeLink(   target: "../bin/ntfs-3g",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/sbin/mount.ntfs",
                    type:   :symbolicLink)

        makeLink(   target: "ntfs-3g.8",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/man/man8/mount.ntfs.8",
                    type:   :symbolicLink)
    end

end
