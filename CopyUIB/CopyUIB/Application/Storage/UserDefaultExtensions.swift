//
//  UserDefault+Extensions.swift
//  UIBank
//
//  Created by 60156664 on 09/01/2023.
//

import Foundation

// MARK: - Main Screen State
public
enum InitialState: String {
    case permission
    case term
    case walkthrough
    case home
}

enum UserDefaultKey: String, CaseIterable {
    case appLanguage
    case appLanguageVersion
    case appMenuVersion
    case languageInfo
    case userId
    case isFirstLogin
    case homeBottomSheetNotSeeCheckList
    case bioAuthentication
    case cusName
    case lastLoginTimeMessage
    case pushToken // APN push token
    case isShowPermissionAlert // For check first time request permission
    case initialState
    case selectedLanguage
    case baseUrl

    // MARK: 로그인 타입
    case loginType
    // MARK: 로그인 정보 등록여부
    case registeredSimpleAuth
    case registeredPattern
    case registeredFingerPrint
    case registeredFaceId
    // MARK: 로그인 방법 활성화여부
    case useSimpleAuth
    case usePattern
    case useFaceId
    case useFingerPrint
    // MARK: For the first loggedIn and recommend biometrics login method
    case isLoggedInBefore

    // MARK: 최종 로그인 성공했을 경우 true설정함
    case isLoggedInBeforeSuccessFlag
    /// first login date.
    case firstLoginDate
    case isEasyMode
    case isMasking
    case invalidPatternCount
    case invalidPinCount
    
    // MARK: New UIbank3.0
    case isDisplayGuide // Show guide banner on home screen
    case isHideHomeLoanAccount // Show hide home loan account setting key
    case isHideHomeForeginAccount // Show hide home foregin account setting key
    case isHideHomeFixAccount // Show hide home fix account setting key
    
    case hideCoachMarkHome // Hide coach Mark on home
    case hideCoachMarkHomeSetting // Hide coach Mark on home setting mode
    case hideCoachMarkWeb // Hide coach Mark on web
    case menuList
    case myMenuListStore
    case myMenuList
    case myMenuDefaultList
    case otherMenuList
    case searchMenuList
    case homeBannerList
    case promotionList
    case isShowToolTipHomeCheckBox
    case isShowToolTipMenuDrag
    case lastNoticeDate

    // MARK: After Login Poup Check Box Data
    case loginAfterExpiredInformCheckBox
    case loginAfterExpectedExpireInformCheckBox
    case loginAfterLongTermUndeferredTradingInformCheckBox
    case loginAfterImmediateDepositInformCheckBox
//    case loginAfterAgreePersonalInfoBox
    
    ///  multi login userId (last lgoin id saved)
    case multiLoginCheckUserId
    
    // MARK: User Id Migration falg
    case userIdMigrated
    // MARK: SimpleAuth Mgiration flag
    case simpleAuthMigrated
    // MARK: KeyChain Mgiration flag
    case keyChainMigrated

}

// MARK: - reset Code
extension UserDefaults {
    func reset() {
        UserDefaultKey.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
    // 초기화시 해당리스트를 제외하고 초기화
    func resetExcept(list:[UserDefaultKey]){
        let setAll = Set(UserDefaultKey.allCases)
        let remove = Set(list)
        let result = setAll.subtracting(remove)
        result.forEach { removeObject(forKey: $0.rawValue) }
    }
    
    // 초기화시 해당리스트를 포함한것만 초기화
    func resetOnly(list:[UserDefaultKey]){
        list.forEach { removeObject(forKey: $0.rawValue) }
    }

}

// MARK: - SimpleAuth Migration Flag
extension UserDefaults {
    /// userIddMigrated migration finished when upgrade or first startup.
    var userIdMigrated: Bool? {
        get { bool(forKey: UserDefaultKey.userIdMigrated.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.userIdMigrated.rawValue)}
    }
    /// simpleAuth migration finished when upgrade or first startup.
    var simpleAuthMigrated: Bool? {
        get { bool(forKey: UserDefaultKey.simpleAuthMigrated.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.simpleAuthMigrated.rawValue)}
    }
    /// keyChain migration finished when upgrade or first startup
    var keyChainMigrated: Bool? {
        get { bool(forKey: UserDefaultKey.keyChainMigrated.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.keyChainMigrated.rawValue)}
    }
}

// MARK: -  After Login Poup Check Box Data
extension UserDefaults {
    var loginAfterExpiredInformCheckBox: Date? {
        get { value(forKey: UserDefaultKey.loginAfterExpiredInformCheckBox.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.loginAfterExpiredInformCheckBox.rawValue)}
    }
    var loginAfterExpectedExpireInformCheckBox: Date?{
        get { value(forKey: UserDefaultKey.loginAfterExpectedExpireInformCheckBox.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.loginAfterExpectedExpireInformCheckBox.rawValue)}
    }
    var loginAfterLongTermUndeferredTradingInformCheckBox: Date? {
        get { value(forKey: UserDefaultKey.loginAfterLongTermUndeferredTradingInformCheckBox.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.loginAfterLongTermUndeferredTradingInformCheckBox.rawValue)}
    }
    var loginAfterImmediateDepositInformCheckBox: Date? {
        get { value(forKey: UserDefaultKey.loginAfterImmediateDepositInformCheckBox.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.loginAfterImmediateDepositInformCheckBox.rawValue)}
    }
//    var loginAfterAgreePersonalInfoBox: Date?{
//        get { value(forKey: UserDefaultKey.loginAfterAgreePersonalInfoBox.rawValue) as? Date }
//        set { setValue(newValue, forKey: UserDefaultKey.loginAfterAgreePersonalInfoBox.rawValue)}
//    }
}

extension UserDefaults {
    func bool(forKey key: UserDefaultKey) -> Bool {
        return bool(forKey: key.rawValue)
    }
    
    func string(forKey key: UserDefaultKey) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func object<T: Decodable>(forKey key: UserDefaultKey) -> T? {
        data(forKey: key.rawValue).flatMap({ try? JSONDecoder().decode(T.self, from: $0) })
    }

    func setObject<T: Encodable>(_ value: T, forKey key: UserDefaultKey) {
        (try? JSONEncoder().encode(value)).map({ setValue($0, forKey: key.rawValue)})
    }
    
    func setValue<T>(_ value: T, forKey key: UserDefaultKey) {
        self.setValue(value, forKey: key.rawValue)
    }
    
    func removeObject(forKey key: UserDefaultKey) {
        removeObject(forKey: key.rawValue)
    }
}


// MARK: - Login Type, Method Related
public
extension UserDefaults {
    // MARK: UIbank 3.0
    var baseUrl: String {
        get { string(forKey: UserDefaultKey.baseUrl.rawValue) ?? ServerConstants.defaultStagingBaseUrl}
        set { setValue(newValue, forKey: UserDefaultKey.baseUrl.rawValue)}
    }

    var initialState: String {
        get { string(forKey: UserDefaultKey.initialState.rawValue) ?? InitialState.permission.rawValue}
        set { setValue(newValue, forKey: UserDefaultKey.initialState.rawValue)}
    }

    var hideCoachMarkHome: Bool {
        get { bool(forKey: UserDefaultKey.hideCoachMarkHome.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.hideCoachMarkHome.rawValue)}
    }

    var hideCoachMarkHomeSetting: Bool {
        get { bool(forKey: UserDefaultKey.hideCoachMarkHomeSetting.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.hideCoachMarkHomeSetting.rawValue)}
    }

    var hideCoachMarkWeb: Bool {
        get { bool(forKey: UserDefaultKey.hideCoachMarkWeb.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.hideCoachMarkWeb.rawValue)}
    }
    
    var isHideHomeLoanAccount: Bool {
        get { bool(forKey: UserDefaultKey.isHideHomeLoanAccount.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isHideHomeLoanAccount.rawValue)}
    }
    
    var isHideHomeForeginAccount: Bool {
        get { bool(forKey: UserDefaultKey.isHideHomeForeginAccount.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isHideHomeForeginAccount.rawValue)}
    }

    var isHideHomeFixAccount: Bool {
        get { bool(forKey: UserDefaultKey.isHideHomeFixAccount.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isHideHomeFixAccount.rawValue)}
    }
    
    // MARK: Login Type
//    var loginType: String {
//        get { string(forKey: UserDefaultKey.loginType.rawValue) ?? LoginType.idPassword.rawValue}
//        set { setValue(newValue, forKey: UserDefaultKey.loginType.rawValue)}
//    }
//    // TODO: - Struct 기반으로 저장 필요
//    var isDisplayGuide: Bool {
//        get { return value(forKey: UserDefaultKey.isDisplayGuide.rawValue) == nil ? true : bool(forKey: .isDisplayGuide) }
//        set { setValue(newValue, forKey: UserDefaultKey.isDisplayGuide.rawValue)}
//    }
    
    // MARK: Login 등록 여부
    var registeredSimpleAuth: Bool {
        get { bool(forKey: UserDefaultKey.registeredSimpleAuth.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.registeredSimpleAuth.rawValue)}
    }
    var registeredPattern: Bool {
        get { bool(forKey: UserDefaultKey.registeredPattern.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.registeredPattern.rawValue)}
    }
    var registeredFingerPrint: Bool {
        get { bool(forKey: UserDefaultKey.registeredFingerPrint.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.registeredFingerPrint.rawValue)}
    }
    var registeredFaceId: Bool {
        get { bool(forKey: UserDefaultKey.registeredFaceId.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.registeredFaceId.rawValue)}
    }
    
    // MARK: 로그인 방법 활성화여부
    var useSimpleAuth: Bool {
        get { bool(forKey: UserDefaultKey.useSimpleAuth.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.useSimpleAuth.rawValue)}
    }
    var usePattern: Bool {
        get { bool(forKey: UserDefaultKey.usePattern.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.usePattern.rawValue)}
    }
    var useFaceId: Bool {
        get { bool(forKey: UserDefaultKey.useFaceId.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.useFaceId.rawValue)}
    }
    var useFingerPrint: Bool {
        get { bool(forKey: UserDefaultKey.useFingerPrint.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.useFingerPrint.rawValue)}
    }
    
    var isLoggedInBefore: Bool {
        get { bool(forKey: UserDefaultKey.isLoggedInBefore.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isLoggedInBefore.rawValue)}
    }

    var isLoggedInBeforeSuccessFlag: Bool {
        get { bool(forKey: UserDefaultKey.isLoggedInBeforeSuccessFlag.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isLoggedInBeforeSuccessFlag.rawValue)}
    }
    
    // store Date Object
    var firstLoginDate: Date? {
        get { value(forKey: UserDefaultKey.firstLoginDate.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.firstLoginDate.rawValue)}
    }

    var invalidPatternCount: Int {
        get { integer(forKey: UserDefaultKey.invalidPatternCount.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.invalidPatternCount.rawValue)}
    }
    
    var invalidPinCount: Int {
        get { integer(forKey: UserDefaultKey.invalidPinCount.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.invalidPinCount.rawValue)}
    }
}

extension UserDefaults {
    var isShowToolTipHomeCheckBox: Bool {
        get { return value(forKey: UserDefaultKey.isShowToolTipHomeCheckBox.rawValue) == nil ? true : bool(forKey: .isShowToolTipHomeCheckBox) }
        set { setValue(newValue, forKey: .isShowToolTipHomeCheckBox)}
    }
    
    var isShowToolTipMenuDrag: Bool {
        get { return value(forKey: UserDefaultKey.isShowToolTipMenuDrag.rawValue) == nil ? true : bool(forKey: .isShowToolTipMenuDrag) }
        set { setValue(newValue, forKey: .isShowToolTipMenuDrag)}
    }
    
    var isShowPermissionAlert: Bool {
        get { bool(forKey: .isShowPermissionAlert) }
        set { setValue(newValue, forKey: .isShowPermissionAlert)}
    }
    
    var bioAuthentication: Bool {
        get { bool(forKey: .bioAuthentication) }
        set { setValue(newValue, forKey: .bioAuthentication)}
    }
    
    var homeBottomSheetNotSeeCheckList: [String] {
        get { object(forKey: .homeBottomSheetNotSeeCheckList) ?? []}
        set { setObject(newValue, forKey: .homeBottomSheetNotSeeCheckList)}
    }
    
    var isFirstLogin: Bool {
        get { return value(forKey: UserDefaultKey.isFirstLogin.rawValue) == nil ? true : bool(forKey: .isFirstLogin) }
        set {
            setValue(newValue, forKey: .isFirstLogin)
        }
    }
    
    var isEasyMode: Bool {
        get { bool(forKey: UserDefaultKey.isEasyMode.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isEasyMode.rawValue)}
    }
    
    var isMasking: Bool {
        get { bool(forKey: UserDefaultKey.isMasking.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.isMasking.rawValue)}
    }
    
    var pushToken: String? {
        get { string(forKey: .pushToken)}
        set { setValue(newValue, forKey: .pushToken)}
    }
    
    var selectedLanguage: String {
        get { string(forKey: .appLanguage) ?? "ja"} // default is ja
        set { setValue(newValue, forKey: .appLanguage)}
    }
    
    var userId: String? {
        get { string(forKey: .userId) }
        set { setValue(newValue, forKey: .userId)}
    }
    
    var cusName: String? {
        get { string(forKey: .cusName) }
        set { newValue == nil ? removeObject(forKey: .cusName) : setValue(newValue, forKey: .cusName)}
    }
    
    var lastLoginTimeMessage: String? {
        get { string(forKey: .lastLoginTimeMessage) }
        set { newValue == nil ? removeObject(forKey: .lastLoginTimeMessage) : setValue(newValue, forKey: .lastLoginTimeMessage)}
    }
    
    var lastNoticeDate: Date? {
        get { value(forKey: UserDefaultKey.lastNoticeDate.rawValue) as? Date }
        set { setValue(newValue, forKey: UserDefaultKey.lastNoticeDate.rawValue)}
    }
    
    var languageCodeVersion: [String: Int] {
        get { object(forKey: .languageInfo) ?? ["ja" : 0,
                                                "ko" : 0] }
        set { setObject(newValue, forKey: .languageInfo)}
    }
    
    var appLanguageVersion: Int {
        get { integer(forKey: UserDefaultKey.appLanguageVersion.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.appLanguageVersion.rawValue)}
    }
    
    var appMenuVersion: Int {
        get { integer(forKey: UserDefaultKey.appMenuVersion.rawValue) }
        set { setValue(newValue, forKey: UserDefaultKey.appMenuVersion.rawValue)}
    }
    
    // UIBank
    //    var otherMenuList: [UIBMenuListInfo]? {
    //        get { object(forKey: .otherMenuList) }
    //        set { setObject(newValue, forKey: .otherMenuList)}
    //    }
    //
    //    var menuList: [UIBMenuInfo]? {
    //        get { object(forKey: .menuList) }
    //        set { setObject(newValue, forKey: .menuList)}
    //    }
    //
    //    var myMenuListStore: [UIBMenuInfo]? {
    //        get { object(forKey: .myMenuListStore) }
    //        set { setObject(newValue, forKey: .myMenuListStore)}
    //    }
    //
    //    var myMenuList: [UIBMenuInfo]? {
    //        get { object(forKey: .myMenuList) }
    //        set { setObject(newValue, forKey: .myMenuList)}
    //    }
    //
    //    var myMenuDefaultList: [UIBMenuInfo]? {
    //        get { object(forKey: .myMenuDefaultList) }
    //        set { setObject(newValue, forKey: .myMenuDefaultList)}
    //    }
    //
    //    var searchMenuList: [UIBMenuInfo]? {
    //        get { object(forKey: .searchMenuList) }
    //        set { setObject(newValue, forKey: .searchMenuList)}
    //    }
    //
    //    // MARK: multi-login check variables
    //    var multiLoginCheckUserId: String? {
    //        get { value(forKey: UserDefaultKey.multiLoginCheckUserId.rawValue) as? String }
    //        set { newValue == nil ? removeObject(forKey: .multiLoginCheckUserId) : setValue(newValue, forKey: .multiLoginCheckUserId)}
    //    }
//}
}
