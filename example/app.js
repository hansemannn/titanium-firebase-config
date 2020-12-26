import TiFirebaseConfig from 'firebase.config';

const window = Ti.UI.createWindow({ backgroundColor: '#fff' });
window.addEventListener('open', () => {
    TiFirebaseConfig.fetch({
        callback: () => {
            TiFirebaseConfig.activateFetched(); // Activate the fetched values
        }
    });
});

window.open();

setTimeout(() => {
    console.warn('String value: ' + TiFirebaseConfig.getString('my_config_string_value'));
}, 2000);