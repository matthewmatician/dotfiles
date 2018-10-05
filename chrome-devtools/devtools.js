const x = new XMLHttpRequest();
x.open('GET', 'style.css');
x.onload = () => chrome.devtools.panels.applyStyleSheet(x.responseText);
x.send();
