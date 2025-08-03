'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "41a36be819f94cd76b20d6006b9677f6",
"version.json": "0da2078bb565906cba8cf11c7f3ffa04",
"preview.png": "bc989cf6145e7e669febbbb4cdae29e2",
"index.html": "aa4b754f3596ec3c6607d86e7000601a",
"/": "aa4b754f3596ec3c6607d86e7000601a",
"main.dart.js": "882ea44602789a1da07d1a91fe4f2964",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "4e1c00567e5fd8927d26abb9fc4010e8",
"logo.png": "b858eec0d5dfa6aa3181e070f0afdded",
"icons/Icon-192.png": "b858eec0d5dfa6aa3181e070f0afdded",
"icons/Icon-maskable-192.png": "b858eec0d5dfa6aa3181e070f0afdded",
"icons/Icon-maskable-512.png": "90395b7ead299b7700b1ed3760e1d29e",
"icons/Icon-512.png": "90395b7ead299b7700b1ed3760e1d29e",
"manifest.json": "87190d0865119e36d8d519d328e8d10d",
"assets/AssetManifest.json": "215bb328b2777075789e9224b95eb885",
"assets/NOTICES": "f9de91810c730345c9c9631f9f4bc410",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "d3dc13e0796c600143a3584f995770d8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "5d61d6d01cea8ce6c693f6feae8bdb6e",
"assets/fonts/MaterialIcons-Regular.otf": "2a81dbd85a22a4c637d2badac95699ae",
"assets/assets/images/dungnguyen.png": "08e155da65242fb16ca80bc5f3acb747",
"assets/assets/images/about_us_banner.png": "bc989cf6145e7e669febbbb4cdae29e2",
"assets/assets/images/recent_scorers/haohoang.jpg": "86a1139097537a0584062d8ad7b61fa2",
"assets/assets/images/recent_scorers/chienloi.jpg": "857d4d097ca1c8995113413c820670ee",
"assets/assets/images/recent_scorers/vanhong.jpg": "61c1e0d594a3afd20a81d08643621bed",
"assets/assets/images/recent_scorers/vando.jpg": "db33ca6460ea7ab1652bb8d38ef8eea3",
"assets/assets/images/recent_scorers/thoale.jpg": "4f45184a0579e465061278432c167381",
"assets/assets/images/recent_scorers/trannguyenthailand.jpg": "866e3426072c2927325b0ddcd397c39d",
"assets/assets/images/recent_scorers/quanglam.jpg": "e82a5d2f5b731bf04924520223d6b7f1",
"assets/assets/images/banner2.jpg": "195123fca91648b20a8731256ee61fd9",
"assets/assets/images/players/dungnguyen.jpg": "77c336f60437e3b165506fb1cedf417b",
"assets/assets/images/players/haohoang.jpg": "33c4ce9a68f5c3f2bc2de439cef2c3f3",
"assets/assets/images/players/dungnguyen.png": "08e155da65242fb16ca80bc5f3acb747",
"assets/assets/images/players/duymap.jpg": "0b6716f05fad57610a0d917a7ad5161c",
"assets/assets/images/players/haule.jpg": "1c1df34e18cf315ddc019ebd785dc449",
"assets/assets/images/players/nguyenthuy.png": "3a1631cc73dbf44cdf51253e44fdb988",
"assets/assets/images/players/binhnguyendanh.png": "749e9c26e78fe070faf123fbd9d97801",
"assets/assets/images/players/thanhtra.png": "9aa635aadc7f44edf57631e36842fd06",
"assets/assets/images/players/vando.png": "8afdd3bf2815ce37aab8bb5b8cbad650",
"assets/assets/images/players/vanhong.png": "d39abb63746d277f83a05741dfc74cec",
"assets/assets/images/players/buonsinoiybackda.png": "1d004a74fab84457514c5aa674109c02",
"assets/assets/images/players/chienloi.png": "738c4c4cfe067fe8291840cf8660c5ee",
"assets/assets/images/players/thanhtra.jpg": "b94c534d540a86c28a12e825d6085d43",
"assets/assets/images/players/viettien.png": "af10e9611934958c99b2055a3e22ebc9",
"assets/assets/images/players/trungle.jpg": "c494794fb4fbb98a75fbfcbdc68e7117",
"assets/assets/images/players/thoale.jpg": "10b92daf6ffb7ffeeab7f54965e84c5e",
"assets/assets/images/players/hoanglich.png": "1e4f575077652ab256615b10c6866e6e",
"assets/assets/images/players/dinhthach.png": "a352c07a31640c87d2020e39ccaaf92a",
"assets/assets/images/players/trannguyenthailand.jpg": "0f8c315ed498a6a203b6692bd03e3459",
"assets/assets/images/players/tunglam.png": "dfdec0028a3bde168f0883ff7c0803cf",
"assets/assets/images/players/sinhgia2020.jpg": "30a8c77b6bff3e7c8bff0eaf124739fa",
"assets/assets/images/players/khai.png": "71596e2a3e98d465b46dd25bc7f89353",
"assets/assets/images/players/hoang.jpg": "863e45c0a2c3b42e8956065d5bb56807",
"assets/assets/images/players/vhieu.png": "71bc3fa94599bd7660fa2ce107aef307",
"assets/assets/images/players/quangteo.png": "a1866b992d4189b5cd023940b4c15e98",
"assets/assets/images/players/buithanhvu.png": "10530ecacb4fe0752ceb1167eff27998",
"assets/assets/images/players/hoangtri.png": "29647960f4600afb92646f3895ab440d",
"assets/assets/images/players/tranhung.png": "eeeeb1c5a34ddb437d2d72eaddfd72fd",
"assets/assets/images/players/truongtuanphuong.png": "6746ac058918f34fb3ab6ef70df7732e",
"assets/assets/images/players/abc.png": "156907de162c96ea4762dcbe102f09f0",
"assets/assets/images/players/tiennguyen.png": "5ab162b5eeb5d3ec1e1e7141c9d17d5e",
"assets/assets/images/players/viethocons.png": "6b6b01d6a757feb7f96d890c1ae5ea4c",
"assets/assets/images/players/dinhlam.png": "84538c11e27dce2cdc72091377a151d5",
"assets/assets/images/players/tuan.png": "faf9f42aa7fcbe873e9c5908b208b914",
"assets/assets/images/players/quanglam.png": "5c41df00339de1949b76f9d1ab6bf13e",
"assets/assets/images/players/nguyendinh.png": "68324199d76022fae2f48f09d4fd9bf3",
"assets/assets/images/players/hung.png": "efb17ee84ed8584f739d603120514291",
"assets/assets/images/players/nguyenthanhtam.png": "332c8e6b47972f8a6c28a2a6ed286d75",
"assets/assets/images/players/hoangdoanvien.png": "73e1121286668bebf02fd6385a2ce1e8",
"assets/assets/images/players/hieu.png": "95a82f2f457592e21277923e2083f9e3",
"assets/assets/images/players/nguyencuong.png": "9e577e94ad8db9d6a9eb8a818359b284",
"assets/assets/images/players/hoconghoa.jpg": "d6bf0b23330c2db902ced4b61fc5065f",
"assets/assets/images/players/hungdoan.png": "08e155da65242fb16ca80bc5f3acb747",
"assets/assets/images/players/hungdoan.jpg": "eeafe15b42c0819fc4e44fa70cc29666",
"assets/assets/images/banner3.jpg": "5e6a2d43209ce1ad838c579a00d3c5dd",
"assets/assets/images/banner1.jpg": "e428977c71da31099b0e373504538a3a",
"assets/assets/images/banner4.jpg": "49c7e2190836e7d6f79ba6a2b05988c5",
"assets/assets/images/banner5.jpg": "7feae0d961198e8b91cecea14b4db8d9",
"assets/assets/images/banner7.jpg": "8db1940aba1c6721a2878d4a89d545f4",
"assets/assets/images/stadium.png": "b2d1ca1ab1036b4704e092d912b2cce6",
"assets/assets/images/banner6.jpg": "aa14757d58f0572e8451873683d93eb1",
"assets/assets/images/banner8.jpg": "216ef498d3544c2bc23cbc93f30a4409",
"assets/assets/images/banner9.jpg": "be1294cb9d4caad92ead445cf7b99d76",
"assets/assets/images/logo.png": "b858eec0d5dfa6aa3181e070f0afdded",
"assets/assets/images/banner11.jpg": "dd9ace2589f6d28fe5815a5feb45d71b",
"assets/assets/images/banner10.jpg": "cc8ba9576d34678359a0107d53e42d88",
"assets/assets/images/banner12.jpg": "8ac00aec5af16500d0b9a7cd9d9af6e9",
"assets/assets/images/banner13.jpg": "e7786bcf36179c5c9d2bd639baa0c803",
"assets/assets/images/hungdoan.png": "08e155da65242fb16ca80bc5f3acb747",
"assets/assets/images/banner14.jpg": "6fd260752b5e057938d15116216b3e27",
"assets/assets/images/banner15.jpg": "f61984fd492ef3cc2c56977cf8700d85",
"assets/assets/icons/vn.png": "47e1003cdb97f364c0bafa85503330ec",
"assets/assets/icons/us.png": "ab291a3ffa8e81386f77c94056c06a5b",
"assets/assets/translations/en.json": "ac81dcf566087a75f9fb79453470c47f",
"assets/assets/translations/vi.json": "77516f1b807189b7edec1c8d5ff9b2b1",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
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
