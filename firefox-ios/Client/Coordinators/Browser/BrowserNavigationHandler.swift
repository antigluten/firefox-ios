// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation
import Storage
import WebKit

import struct MozillaAppServices.CreditCard
import enum MozillaAppServices.VisitType

protocol BrowserNavigationHandler: AnyObject, QRCodeNavigationHandler {
    /// Asks to show a settings page, can be a general settings page or a child page
    /// - Parameter settings: The settings route we're trying to get to
    /// - Parameter onDismiss: An optional closure that is executed when the settings page is dismissed.
    /// This closure takes no parameters and returns no value.
    func show(settings: Route.SettingsSection, onDismiss: (() -> Void)?)

    /// Asks to show a enhancedTrackingProtection page, can be a general
    /// enhancedTrackingProtection page or a child page
    func showEnhancedTrackingProtection(sourceView: UIView)

    /// Shows the specified section of the home panel.
    ///
    /// - Parameter homepanelSection: The section to be displayed.
    func show(homepanelSection: Route.HomepanelSection)

    /// Shows the share sheet.
    ///
    /// - Parameter shareType: The content to be shared.
    /// - Parameter shareMessage: An optional plain text message to be shared.
    /// - Parameter sourceView: The reference view to show the popoverViewController.
    /// - Parameter sourceRect: An optional rect to use for ipad popover presentation.
    /// - Parameter toastContainer: The view in which is displayed the toast results from actions in the share extension.
    /// - Parameter popoverArrowDirection: The arrow direction for the view controller presented as popover.
    func showShareSheet(shareType: ShareType,
                        shareMessage: ShareMessage?,
                        sourceView: UIView,
                        sourceRect: CGRect?,
                        toastContainer: UIView,
                        popoverArrowDirection: UIPopoverArrowDirection)

    /// Shows a CreditCardAutofill view to select credit cards in order to autofill cards forms.
    func showCreditCardAutofill(creditCard: CreditCard?,
                                decryptedCard: UnencryptedCreditCardFields?,
                                viewType state: CreditCardBottomSheetState,
                                frame: WKFrameInfo?,
                                alertContainer: UIView)

    /// Displays an autofill interface for saved logins, allowing the user to select from stored login credentials
    /// to autofill login forms on the specified web page.
    func showSavedLoginAutofill(tabURL: URL, currentRequestId: String, field: FocusFieldType)

    /// Shows an AddressAutofill view for selecting addresses in order to autofill forms.
    func showAddressAutofill(frame: WKFrameInfo?)

    /// Shows authentication view controller to authorize access to sensitive data.
    func showRequiredPassCode()

    /// Shows the Tab Tray View Controller.
    func showTabTray(selectedPanel: TabTrayPanelType)

    /// Shows the Back Forward List View Controller.
    func showBackForwardList()

    func showMicrosurvey(model: MicrosurveyModel)

    func showPasswordGenerator(tab: Tab, frame: WKFrameInfo)

    /// Shows the app menu
    func showMainMenu()

    /// Shows the toolbar's search engine selection bottom sheet (iPhone) or popup (iPad)
    func showSearchEngineSelection(forSourceView sourceView: UIView)

    /// Navigates from home page to a new link
    func navigateFromHomePanel(to url: URL, visitType: VisitType, isGoogleTopSite: Bool)

    /// Navigates to our custom context menu (Photon Action Sheet)
    func showContextMenu(for configuration: ContextMenuConfiguration)

    /// Navigates to the edit bookmark view
    func showEditBookmark(parentFolder: FxBookmarkNode, bookmark: FxBookmarkNode)

    func openInNewTab(url: URL, isPrivate: Bool, selectNewTab: Bool)

    /// Shows the Document loading view on screen
    func showDocumentLoading()

    /// Removes the Document loading view from screen
    func removeDocumentLoading()
}

extension BrowserNavigationHandler {
    func show(settings: Route.SettingsSection) {
        show(settings: settings, onDismiss: nil)
    }
}
