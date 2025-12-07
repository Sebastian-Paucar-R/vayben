import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.papadoctor.app',      // cambia si quieres
  appName: 'PapaDoctor',
  webDir: 'dist',                    // ¡¡¡ESTA ES LA CLAVE!!!
  bundledWebRuntime: false,
  server: {
    androidScheme: 'https'
  }
};

export default config;