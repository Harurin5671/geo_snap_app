########## FLUTTER CORE ##########
# Retener todo lo de Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Evita que se elimine MainActivity
-keep class com.surefusion.geo_snap.MainActivity { *; }

########## FLUTTER_BLOC ##########
# Bloc usa tipos genéricos y reflexión a veces, mejor asegurarlo
-keep class * implements flutter_bloc.** { *; }
-dontwarn flutter_bloc.**

########## CAMERA / CAMERAX ##########
# Evita problemas con androidx.camera
-keep class androidx.camera.** { *; }
-dontwarn androidx.camera.**

# Para evitar errores en JNI u observadores
-keep class io.flutter.plugins.camerax.** { *; }
-dontwarn io.flutter.plugins.camerax.**

########## DRIFT (antes moor) ##########
# Drift usa generación de código y reflexión
-keepclassmembers class * extends androidx.room.RoomDatabase {
    <init>(...);
}
-keepclassmembers class * extends androidx.room.RoomDatabase {
    public static *** databaseBuilder(...);
}

# Retener clases DAO y DB
-keep class **.GeoSnapDatabase { *; }
-keep class **.PhotoDao { *; }

# Drift genera código que a veces es eliminado
-keep class *.drift.** { *; }
-dontwarn *.drift.**

########## JSON / REFLEXIÓN (opcional, si usas json_serializable o similar) ##########
-keepclassmembers class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

########## GENERAL ##########
# Evita remover las anotaciones (útil para Gson/Room/Drift)
-keepattributes *Annotation*

# Para evitar advertencias innecesarias
-dontwarn kotlin.Metadata
-dontwarn sun.misc.**

########## DEBUG ##########
# Puedes comentar esta línea cuando estés listo para ofuscar por completo
-dontobfuscate
