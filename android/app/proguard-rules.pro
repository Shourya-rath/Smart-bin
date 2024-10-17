# Keep all the classes in your project
-keep class com.example.smartbin.** { *; }

# Keep all classes with the @Keep annotation
-keep @androidx.annotation.Keep class * { *; }

# Keep classes used by Flutter and Firebase
-keep class io.flutter.app.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.play.core.** { *; }

# Additional keep rule for the entire com.google.android.play.core package
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.internal.** { *; }
-keep class com.google.android.play.core.internal.splitinstall.** { *; }
-keep class com.google.android.play.core.internal.splitinstall.SplitInstallManager { *; }
-keep class com.google.android.play.core.internal.splitinstall.SplitInstallManagerFactory { *; }
-keep class com.google.android.play.core.internal.splitinstall.SplitInstallRequest$Builder { *; }
-keep class com.google.android.play.core.internal.splitinstall.SplitInstallRequest { *; }
-keep class com.google.android.play.core.internal.splitinstall.SplitInstallStateUpdatedListener { *; }
-keep class com.google.android.play.core.internal.tasks.** { *; }
-keep class com.google.android.play.core.internal.tasks.OnFailureListener { *; }
-keep class com.google.android.play.core.internal.tasks.OnSuccessListener { *; }
-keep class com.google.android.play.core.internal.tasks.Task { *; }

##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken


# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

##---------------End: proguard configuration for Gson  ----------