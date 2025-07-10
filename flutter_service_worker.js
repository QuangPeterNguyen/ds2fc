'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "3b0393842a25e8a12dc0863ff1741be9",
"assets/AssetManifest.bin.json": "02b2c7cf1f482284b2f593b73b502891",
"assets/AssetManifest.json": "6524d329bfd76a2a3c036e6706b0c0e2",
"assets/assets/icons/us.png": "ab291a3ffa8e81386f77c94056c06a5b",
"assets/assets/icons/vn.png": "47e1003cdb97f364c0bafa85503330ec",
"assets/assets/images/banner1.jpg": "e428977c71da31099b0e373504538a3a",
"assets/assets/images/banner10.jpg": "cc8ba9576d34678359a0107d53e42d88",
"assets/assets/images/banner11.jpg": "dd9ace2589f6d28fe5815a5feb45d71b",
"assets/assets/images/banner12.jpg": "8ac00aec5af16500d0b9a7cd9d9af6e9",
"assets/assets/images/banner13.jpg": "e7786bcf36179c5c9d2bd639baa0c803",
"assets/assets/images/banner14.jpg": "6fd260752b5e057938d15116216b3e27",
"assets/assets/images/banner15.jpg": "f61984fd492ef3cc2c56977cf8700d85",
"assets/assets/images/banner2.jpg": "195123fca91648b20a8731256ee61fd9",
"assets/assets/images/banner3.jpg": "5e6a2d43209ce1ad838c579a00d3c5dd",
"assets/assets/images/banner4.jpg": "49c7e2190836e7d6f79ba6a2b05988c5",
"assets/assets/images/banner5.jpg": "7feae0d961198e8b91cecea14b4db8d9",
"assets/assets/images/banner6.jpg": "aa14757d58f0572e8451873683d93eb1",
"assets/assets/images/banner7.jpg": "8db1940aba1c6721a2878d4a89d545f4",
"assets/assets/images/banner8.jpg": "216ef498d3544c2bc23cbc93f30a4409",
"assets/assets/images/banner9.jpg": "be1294cb9d4caad92ead445cf7b99d76",
"assets/assets/images/logo/avatar_placeholder.png": "39288f70737ba9af5dd993cc3015c211",
"assets/assets/images/logo/drawer_icon.png": "af82a442fa4840a90668ff2843216520",
"assets/assets/translations/en.json": "bdb1990f54b5cd05df5c7d93f5c271a6",
"assets/assets/translations/vi.json": "b6f890524b1f1c02d1f80dec004a91a9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "e298cbe519493a8f678dac2169a1276b",
"assets/NOTICES": "5c86e136117e822dd7849d8e56d6bc4a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "2ee46f1d09ced6c9f62c8c265a22c332",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "6a1ff29ef59ba76a9cbe97e5a2699bad",
"icons/Icon-192.png": "39288f70737ba9af5dd993cc3015c211",
"icons/Icon-512.png": "257abdefe61f4e1f644ffb3104c8dd04",
"icons/Icon-maskable-192.png": "39288f70737ba9af5dd993cc3015c211",
"icons/Icon-maskable-512.png": "257abdefe61f4e1f644ffb3104c8dd04",
"index.html": "3b2dd83c0b6645a18a7f4b4c4dc8e11e",
"/": "3b2dd83c0b6645a18a7f4b4c4dc8e11e",
"main.dart.js": "27a077252c19922a75beb131a50df9f6",
"manifest.json": "4d7747d571a999b450e9a64af0ed2eba",
"version.json": "0da2078bb565906cba8cf11c7f3ffa04"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
