inherit populate_sdk_qt5

# Qt
IMAGE_INSTALL_append = " \
	qtbase \
	qtbase-plugins \
	qtbase-tools  \
	qtquickcontrols-qmlplugins \
	qtgraphicaleffects-qmlplugins \
	qtquickcontrols2 \
	qtdeclarative \
	ttf-dejavu-sans ttf-dejavu-sans-mono ttf-dejavu-sans-condensed \
	ttf-dejavu-serif ttf-dejavu-serif-condensed ttf-dejavu-common \
	"

# Tool
IMAGE_INSTALL_append = " \
	dtc \
	"	
