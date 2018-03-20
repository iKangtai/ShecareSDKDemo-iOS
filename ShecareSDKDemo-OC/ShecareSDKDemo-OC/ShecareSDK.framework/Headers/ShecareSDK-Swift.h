// Generated by Apple Swift version 4.0.3 (swiftlang-900.0.74.1 clang-900.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
@import Foundation;
@import CoreBluetooth;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("ShecareSDK")
/// 用户硬件镜像版本
typedef SWIFT_ENUM(NSInteger, BLEFirmwareImageType) {
/// 未知版本
  BLEFirmwareImageTypeUnknown = 0,
/// A 版本
  BLEFirmwareImageTypeTypeA = 1,
/// B 版本
  BLEFirmwareImageTypeTypeB = 2,
};

typedef SWIFT_ENUM(NSInteger, BLENotifyType) {
  BLENotifyTypeSetTemperatureUnitC = 0,
  BLENotifyTypeSetTemperatureUnitF = 1,
  BLENotifyTypeTransmitTemperature = 2,
  BLENotifyTypeTemperatureCount = 3,
  BLENotifyTypeThermometerPower = 4,
};

@class CBPeripheral;
@protocol BLEThermometerDelegate;
@class CBCharacteristic;
enum YCBLEConnectType : NSInteger;
enum YCBLEState : NSInteger;

SWIFT_CLASS("_TtC10ShecareSDK14BLEThermometer")
@interface BLEThermometer : NSObject
@property (nonatomic, strong) CBPeripheral * _Nullable activePeripheral;
@property (nonatomic, copy) NSString * _Nonnull firmwareVersion;
@property (nonatomic, copy) NSString * _Nonnull macAddress;
@property (nonatomic) BOOL isOADing;
@property (nonatomic) uint16_t imgVersion;
@property (nonatomic, weak) id <BLEThermometerDelegate> _Nullable delegate;
@property (nonatomic, strong) CBCharacteristic * _Nullable imageTypeChar;
@property (nonatomic, strong) CBCharacteristic * _Nullable oadBlockRequestChar;
@property (nonatomic) NSInteger oadResponseCount;
@property (nonatomic, copy) void (^ _Nullable oadAction)(BLEThermometer * _Nonnull, NSInteger);
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
/// 单例
+ (BLEThermometer * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (BOOL)connectThermometerWithType:(enum YCBLEConnectType)type macList:(NSString * _Nonnull)macList SWIFT_WARN_UNUSED_RESULT;
- (void)stopScan;
- (enum YCBLEState)bleState SWIFT_WARN_UNUSED_RESULT;
- (void)disconnectActiveThermometer;
- (void)asynchroizationTimeFromLocalWithDate:(NSDate * _Nonnull)date;
- (void)setNotifyValueWithType:(enum BLENotifyType)type value:(uint8_t)value;
@end

@class CBCentralManager;
@class NSNumber;

@interface BLEThermometer (SWIFT_EXTENSION(ShecareSDK)) <CBCentralManagerDelegate>
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
- (void)centralManager:(CBCentralManager * _Nonnull)central willRestoreState:(NSDictionary<NSString *, id> * _Nonnull)dict;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
- (void)centralManager:(CBCentralManager * _Nonnull)central didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)centralManager:(CBCentralManager * _Nonnull)central didFailToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
@end

@class CBService;

@interface BLEThermometer (SWIFT_EXTENSION(ShecareSDK)) <CBPeripheralDelegate>
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverServices:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverCharacteristicsForService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
@end

@class YCTemperatureModel;

SWIFT_PROTOCOL("_TtP10ShecareSDK22BLEThermometerDelegate_")
@protocol BLEThermometerDelegate <NSObject>
- (void)bleThermometerDidUpdateState:(BLEThermometer * _Nonnull)bleThermometer;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didReadFirmwareImageType:(enum BLEFirmwareImageType)type;
@optional
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didConnect:(CBPeripheral * _Nonnull)peripheral;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didFailToConnect:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didDisconnect:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didUpload:(NSArray<YCTemperatureModel *> * _Nonnull)temperatures;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didSetTemperatureUnit:(BOOL)success;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didGetFirmwareVersion:(NSString * _Nonnull)firmwareVersion;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didSetThermometerTime:(BOOL)success;
- (void)bleThermometerDidGetTemperature:(BLEThermometer * _Nonnull)bleThermometer;
- (void)bleThermometer:(BLEThermometer * _Nonnull)bleThermometer didGetThermometerPower:(double)value;
@end






@interface NSError (SWIFT_EXTENSION(ShecareSDK))
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSError * _Nonnull unknownError;)
+ (NSError * _Nonnull)unknownError SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSError * _Nonnull serverError;)
+ (NSError * _Nonnull)serverError SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSError * _Nonnull unbindError;)
+ (NSError * _Nonnull)unbindError SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSError * _Nonnull bindedByOthersError;)
+ (NSError * _Nonnull)bindedByOthersError SWIFT_WARN_UNUSED_RESULT;
@end





@class YCPeriodModel;
@class YCUserInfoModel;
@class NSDictionary;

SWIFT_CLASS("_TtC10ShecareSDK14ShecareService")
@interface ShecareService : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
/// 单例
+ (ShecareService * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
/// 设置 UserID
/// \param identifier 需保证同一个 appID 下的唯一性
///
- (void)setUserIdentifier:(NSString * _Nonnull)identifier;
/// 设置 appID
/// \param identifier 由 SaaS 服务端提供
///
- (void)setApplicationIdentifier:(NSString * _Nonnull)identifier;
/// 设置 appSecret
/// \param identifier 由 SaaS 服务端提供
///
- (void)setApplicationSecret:(NSString * _Nonnull)identifier;
- (BOOL)needInitData SWIFT_WARN_UNUSED_RESULT;
- (void)initDataWithTemperatures:(NSArray<YCTemperatureModel *> * _Nullable)temperatures periods:(NSArray<YCPeriodModel *> * _Nullable)periods userInfo:(YCUserInfoModel * _Nonnull)userInfo completion:(void (^ _Nonnull)(BOOL))completion SWIFT_METHOD_FAMILY(none);
- (void)uploadWithTemperatures:(NSArray<YCTemperatureModel *> * _Nullable)temperatures completion:(void (^ _Nonnull)(BOOL))completion;
- (void)uploadWithPeriods:(NSArray<YCPeriodModel *> * _Nullable)periods completion:(void (^ _Nonnull)(BOOL))completion;
- (void)uploadWithUserInfo:(YCUserInfoModel * _Nonnull)userInfo completion:(void (^ _Nonnull)(BOOL))completion;
- (NSString * _Nonnull)temperatureCharts SWIFT_WARN_UNUSED_RESULT;
- (void)analysis:(void (^ _Nonnull)(NSError * _Nullable, NSDictionary * _Nullable))completion;
- (void)unBindWithMacAddress:(NSString * _Nonnull)macAddress completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
@end

























/// 蓝牙连接类型
typedef SWIFT_ENUM(NSInteger, YCBLEConnectType) {
/// 绑定页的连接，可以连接所有设备
  YCBLEConnectTypeBinding = 0,
/// 非绑定页的连接，只能连接已绑定的设备
  YCBLEConnectTypeNotBinding = 1,
};

typedef SWIFT_ENUM(NSInteger, YCBLEMeasureFlag) {
  YCBLEMeasureFlagOnline = 0,
  YCBLEMeasureFlagOfflineBegin = 1,
  YCBLEMeasureFlagOfflineEnd = 2,
  YCBLEMeasureFlagUnknown = 3,
};

typedef SWIFT_ENUM(NSInteger, YCBLEState) {
  YCBLEStateValid = 0,
  YCBLEStateUnknown = 1,
  YCBLEStateUnsupported = 2,
  YCBLEStateUnauthorized = 3,
  YCBLEStatePoweredOff = 4,
  YCBLEStateResetting = 5,
};

@protocol YCBindViewControllerDelegate;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC10ShecareSDK20YCBindViewController")
@interface YCBindViewController : UIViewController
@property (nonatomic, weak) id <YCBindViewControllerDelegate> _Nullable delegate;
- (void)viewDidLoad;
- (void)viewDidDisappear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end






SWIFT_PROTOCOL("_TtP10ShecareSDK28YCBindViewControllerDelegate_")
@protocol YCBindViewControllerDelegate <NSObject>
- (void)bindViewController:(YCBindViewController * _Nonnull)bindViewController didBind:(NSString * _Nonnull)macAddress;
- (void)bindViewController:(YCBindViewController * _Nonnull)bindViewController didFailedToBind:(NSString * _Nonnull)macAddress errorMessage:(NSString * _Nonnull)errorMessage;
@end


SWIFT_CLASS("_TtC10ShecareSDK13YCPeriodModel")
@interface YCPeriodModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithDate:(NSDate * _Nonnull)date period:(NSInteger)period status:(NSInteger)status;
@end

@class NSString;

SWIFT_CLASS("_TtC10ShecareSDK18YCTemperatureModel")
@interface YCTemperatureModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithTemperature:(NSString * _Nonnull)temperature measureTime:(NSDate * _Nonnull)date deleted:(BOOL)deleted;
@end


SWIFT_CLASS("_TtC10ShecareSDK15YCUserInfoModel")
@interface YCUserInfoModel : NSObject
@property (nonatomic) float cycleLength;
@property (nonatomic) float mensLength;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithCycleLength:(NSInteger)cycleLength mensLength:(NSInteger)mensLength;
@end

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
