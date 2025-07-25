add_subdirectory(platform)
add_subdirectory(primitives)
add_subdirectory(delegates)
add_subdirectory(dialogs)
add_subdirectory(layouts)
add_subdirectory(polyfill)
add_subdirectory(templates)

add_library(Kirigami)
add_library(KF6::Kirigami ALIAS Kirigami)

# On Windows Kirigami apparently adds too many sources so on Windows we end
# up running into command line length limits. So disable cache
# generation on Windows for now.
# On Qt 6.7.2 cachegen is causing https://bugs.kde.org/show_bug.cgi?id=488326
# investigate if future versions fix it and we can re-enable it
if (NOT ANDROID)
    set(_extra_options NO_CACHEGEN)
endif()
if (BUILD_SHARED_LIBS)
    set(_extra_options ${_extra_options} NO_PLUGIN_OPTIONAL)
endif()
if (ANDROID OR NOT BUILD_SHARED_LIBS)
    set(_extra_options ${_extra_options} OPTIONAL_IMPORTS org.kde.breeze)
endif()

# Module: org.kde.kirigami.private

add_library(KirigamiPrivate)
ecm_add_qml_module(KirigamiPrivate
    URI "org.kde.kirigami.private"
    GENERATE_PLUGIN_SOURCE
    INSTALLED_PLUGIN_TARGET KF6KirigamiPrivateplugin
)

set_target_properties(KirigamiPrivate PROPERTIES
    VERSION     ${PROJECT_VERSION}
    SOVERSION   6
    EXPORT_NAME "KirigamiPrivate"
)

target_sources(KirigamiPrivate PRIVATE
    copyhelper.cpp
    copyhelper.h
    actionhelper.cpp
    actionhelper.h
)

target_link_libraries(KirigamiPrivate PRIVATE Qt6::Gui)

ecm_finalize_qml_module(KirigamiPrivate DESTINATION ${KDE_INSTALL_QMLDIR} EXPORT KirigamiTargets)

install(TARGETS KirigamiPrivate EXPORT KirigamiTargets ${KF_INSTALL_TARGETS_DEFAULT_ARGS})

# Module: org.kde.kirigami

ecm_add_qml_module(Kirigami URI "org.kde.kirigami" VERSION 2.0
    CLASS_NAME KirigamiPlugin
    INSTALLED_PLUGIN_TARGET KF6Kirigamiplugin
    DEPENDENCIES
    "QtQuick.Controls"
    "org.kde.kirigami.private"
    "org.kde.kirigami.private.polyfill"
    IMPORTS
    "org.kde.kirigami.platform"
    "org.kde.kirigami.primitives"
    "org.kde.kirigami.delegates"
    "org.kde.kirigami.dialogs"
    "org.kde.kirigami.layouts"
    ${_extra_options}
)

ecm_create_qm_loader(kirigami_QM_LOADER libkirigami6_qt)
target_sources(Kirigami PRIVATE ${kirigami_QM_LOADER})

ecm_qt_declare_logging_category(Kirigami
    HEADER loggingcategory.h
    IDENTIFIER KirigamiLog
    CATEGORY_NAME kf.kirigami
    DESCRIPTION "Kirigami"
    DEFAULT_SEVERITY Warning
    EXPORT KIRIGAMI
)

set_target_properties(Kirigami PROPERTIES
    VERSION     ${PROJECT_VERSION}
    SOVERSION   6
    EXPORT_NAME "Kirigami"
)

target_include_directories(Kirigami PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/platform
    ${CMAKE_CURRENT_BINARY_DIR}/platform
)

target_sources(Kirigami PRIVATE
    enums.h
    imagecolors.cpp
    imagecolors.h
    mnemonicattached.cpp
    mnemonicattached.h
    overlayzstackingattached.cpp
    overlayzstackingattached.h
    pagepool.cpp
    pagepool.h
    scenepositionattached.cpp
    scenepositionattached.h
    spellcheckattached.cpp
    spellcheckattached.h
    wheelhandler.cpp
    wheelhandler.h
)

target_sources(Kirigamiplugin PRIVATE
    kirigamiplugin.cpp
    kirigamiplugin.h
)

ecm_target_qml_sources(Kirigami SOURCES
    controls/Action.qml
    controls/AbstractApplicationHeader.qml
    controls/AbstractApplicationWindow.qml
    controls/ApplicationWindow.qml
    controls/OverlayDrawer.qml
    controls/ContextDrawer.qml
    controls/GlobalDrawer.qml
    controls/Heading.qml
    controls/PageRow.qml
    controls/OverlaySheet.qml
    controls/Page.qml
    controls/ScrollablePage.qml
    controls/SwipeListItem.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.1 SOURCES
    controls/AbstractApplicationItem.qml
    controls/ApplicationItem.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.4 SOURCES
    controls/AbstractCard.qml
    controls/Card.qml
    controls/CardsListView.qml
    controls/CardsLayout.qml
    controls/InlineMessage.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.5 SOURCES
    controls/ListItemDragHandle.qml
    controls/ActionToolBar.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.6 SOURCES
    controls/AboutPage.qml
    controls/LinkButton.qml
    controls/UrlButton.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.7 SOURCES
    controls/ActionTextField.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.8 SOURCES
    controls/SearchField.qml
    controls/PasswordField.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.10 SOURCES
    controls/ListSectionHeader.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.11 SOURCES
    controls/PagePoolAction.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.12 SOURCES
    controls/PlaceholderMessage.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.14 SOURCES
    controls/FlexColumn.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.19 SOURCES
    controls/AboutItem.qml
    controls/NavigationTabBar.qml
    controls/NavigationTabButton.qml
    controls/Chip.qml
    controls/LoadingPlaceholder.qml
)

ecm_target_qml_sources(Kirigami VERSION 2.20 SOURCES
    controls/SelectableLabel.qml
    controls/InlineViewHeader.qml
    controls/ContextualHelpButton.qml
)

ecm_target_qml_sources(Kirigami PRIVATE PATH private SOURCES
    controls/private/ActionMenuItem.qml
    controls/private/ActionsMenu.qml
    controls/private/BannerImage.qml
    controls/private/ContextDrawerActionItem.qml
    controls/private/DefaultCardBackground.qml
    controls/private/DefaultChipBackground.qml
    controls/private/DefaultPageTitleDelegate.qml
    controls/private/EdgeShadow.qml
    controls/private/GlobalDrawerActionItem.qml
    controls/private/MobileDialogLayer.qml
    controls/private/PrivateActionToolButton.qml
    controls/private/PullDownIndicator.qml
    controls/private/SwipeItemEventFilter.qml
)

ecm_target_qml_sources(Kirigami PRIVATE PATH private/globaltoolbar SOURCES
    controls/private/globaltoolbar/BreadcrumbControl.qml
    controls/private/globaltoolbar/NavigationButtons.qml
    controls/private/globaltoolbar/PageRowGlobalToolBarStyleGroup.qml
    controls/private/globaltoolbar/PageRowGlobalToolBarUI.qml
    controls/private/globaltoolbar/ToolBarPageHeader.qml
    controls/private/globaltoolbar/ToolBarPageFooter.qml
)

qt_target_qml_sources(Kirigami RESOURCES
    styles/Material/InlineMessage.qml
    styles/Material/Theme.qml
    OUTPUT_TARGETS _out_targets_1
)

if (DESKTOP_ENABLED)
    qt_target_qml_sources(Kirigami RESOURCES
        styles/org.kde.desktop/AbstractApplicationHeader.qml
        styles/org.kde.desktop/Theme.qml
        OUTPUT_TARGETS _out_targets_2
    )
endif()

target_link_libraries(Kirigami
    PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    PRIVATE
    Qt6::Concurrent
    ${Kirigami_EXTRA_LIBS}
)

if (HAVE_OpenMP)
    target_link_libraries(Kirigami PRIVATE OpenMP::OpenMP_CXX)
endif()

if (NOT BUILD_SHARED_LIBS)
    # Ensure we install the plugin library file as that's required to link
    # against for static builds to work properly
    target_link_libraries(Kirigamiplugin
        PRIVATE
            KirigamiPlatformplugin
            KirigamiDelegatesplugin
            KirigamiPrimitivesplugin
            KirigamiDialogsplugin
            KirigamiLayoutsplugin
            KirigamiLayoutsPrivateplugin
            KirigamiPrivateplugin
            KirigamiTemplatesplugin
    )
    # for tests to find this under the name it's actually installed with'
    add_library(KF6Kirigamiplugin ALIAS Kirigamiplugin)
else()
    target_link_libraries(Kirigami
        PUBLIC
            KirigamiPlatform
        PRIVATE
            KirigamiDelegates
            KirigamiPrimitives
            KirigamiDialogs
            KirigamiLayouts
            KirigamiPrivate
            KirigamiTemplates
    )
endif()

install(TARGETS Kirigami ${_out_targets_1} ${_out_targets_2} EXPORT KirigamiTargets ${KF_INSTALL_TARGETS_DEFAULT_ARGS})
install(EXPORT KirigamiTargets
    DESTINATION ${KDE_INSTALL_CMAKEPACKAGEDIR}/KF6Kirigami
    FILE KF6KirigamiTargets.cmake
    NAMESPACE KF6
)

ecm_finalize_qml_module(Kirigami DESTINATION ${KDE_INSTALL_QMLDIR} EXPORT KirigamiTargets)

if (ANDROID)
    install(FILES Kirigami-android-dependencies.xml
        DESTINATION ${KDE_INSTALL_LIBDIR}
        RENAME Kirigami_${CMAKE_ANDROID_ARCH_ABI}-android-dependencies.xml
    )
endif()

ecm_qt_install_logging_categories(
    EXPORT KIRIGAMI
    FILE kirigami.categories
    DESTINATION ${KDE_INSTALL_LOGGINGCATEGORIESDIR}
)

ecm_generate_qdoc(Kirigami kirigami.qdocconf)
