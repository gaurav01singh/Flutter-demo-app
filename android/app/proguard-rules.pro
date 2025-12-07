# Prevent removal of Android 13+ back gesture classes
-keep class android.window.** { *; }

# Keep Flutter WebView related classes
-keep class io.flutter.** { *; }
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
