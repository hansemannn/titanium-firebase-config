import TiFirebaseConfig from 'firebase.config';

const window = Ti.UI.createWindow({ backgroundColor: '#fff' });
window.addEventListener('open', () => {
  TiFirebaseConfig.setDefaults({
    stringValue: "Test",
    numberValue: 12345.00,
    booleanValue: true
  });

  TiFirebaseConfig.fetchAndActivate(function(e) {
    if (e.success) {
      Ti.API.info('String value: ' + TiFirebaseConfig.getString('stringValue'));
      Ti.API.info('Number value: ' + TiFirebaseConfig.getNumber('numberValue'));
      Ti.API.info('Boolean value: ' + TiFirebaseConfig.getBool('boolValue'));
    }
  });
});

window.open();

setTimeout(() => {
    console.warn('String value: ' + TiFirebaseConfig.getString('stringValue'));
}, 2000);
