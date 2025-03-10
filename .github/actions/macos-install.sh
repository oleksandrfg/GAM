echo "MacOS Version Info According to Python:"
macver=$(python -c "import platform; print(platform.mac_ver()[0])")
echo $macver
echo "Xcode version:"
xcodebuild -version
export distpath="dist/"
export gampath="${distpath}"
rm -rf $gampath
export specfile="gam.spec"
if [ "$macver" == "10.15.7" ]; then
	youtoo=""
else
	youtoo=""
fi
$python -OO -m PyInstaller --clean --noupx --strip --distpath "${distpath}" $youtoo "${specfile}"
export gam="${gampath}/gam"
$gam version extended
export GAMVERSION=`$gam version simple`
cp LICENSE "${gampath}"
cp GamCommands.txt "${gampath}"
GAM_ARCHIVE="gam-${GAMVERSION}-${GAMOS}-${PLATFORM}.tar.xz"
rm "${gampath}/lastupdatecheck.txt"
# tar will cd to dist/ and tar up gam/
tar -C dist/ --create --file $GAM_ARCHIVE --xz gam
