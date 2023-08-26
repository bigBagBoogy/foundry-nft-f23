//to run:   node base64.js

const svgString = `<svg version="1.1" id="Icons" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
	 viewBox="0 0 32 32" xml:space="preserve">
<style type="text/css">
	.st0{fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;}
</style>
<path d="M31,16h-2v-2c0-0.6-0.4-1-1-1h-2v-2c0-0.6-0.4-1-1-1h-2V8h2c0.6,0,1-0.4,1-1V4c0-0.6-0.4-1-1-1h-3c-0.6,0-1,0.4-1,1v2h-2
	c-0.6,0-1,0.4-1,1v3h-4V7c0-0.6-0.4-1-1-1h-2V4c0-0.6-0.4-1-1-1H7C6.4,3,6,3.4,6,4v3c0,0.6,0.4,1,1,1h2v2H7c-0.6,0-1,0.4-1,1v2H4
	c-0.6,0-1,0.4-1,1v2H1c-0.6,0-1,0.4-1,1v9c0,0.6,0.4,1,1,1h3c0.6,0,1-0.4,1-1v-5h1v5c0,0.6,0.4,1,1,1h2v2c0,0.6,0.4,1,1,1h4
	c0.6,0,1-0.4,1-1v-3c0-0.6-0.4-1-1-1h-3v-1h10v1h-3c-0.6,0-1,0.4-1,1v3c0,0.6,0.4,1,1,1h4c0.6,0,1-0.4,1-1v-2h2c0.6,0,1-0.4,1-1v-5
	h1v5c0,0.6,0.4,1,1,1h3c0.6,0,1-0.4,1-1v-9C32,16.4,31.6,16,31,16z M14,19c0,0.6-0.4,1-1,1h-3c-0.6,0-1-0.4-1-1v-3c0-0.6,0.4-1,1-1
	h3c0.6,0,1,0.4,1,1V19z M23,19c0,0.6-0.4,1-1,1h-3c-0.6,0-1-0.4-1-1v-3c0-0.6,0.4-1,1-1h3c0.6,0,1,0.4,1,1V19z"/>
</svg>
`;

// Remove newlines and spaces from the SVG string
const cleanSvgString = svgString.replace(/\s+/g, " ");

// Convert the SVG string to base64
const base64Svg = btoa(cleanSvgString);

console.log(base64Svg);

//     space-invader:     data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJJY29ucyIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWw6c3BhY2U9InByZXNlcnZlIj4gPHN0eWxlIHR5cGU9InRleHQvY3NzIj4gLnN0MHtmaWxsOm5vbmU7c3Ryb2tlOiMwMDAwMDA7c3Ryb2tlLXdpZHRoOjI7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS1taXRlcmxpbWl0OjEwO30gPC9zdHlsZT4gPHBhdGggZD0iTTMxLDE2aC0ydi0yYzAtMC42LTAuNC0xLTEtMWgtMnYtMmMwLTAuNi0wLjQtMS0xLTFoLTJWOGgyYzAuNiwwLDEtMC40LDEtMVY0YzAtMC42LTAuNC0xLTEtMWgtM2MtMC42LDAtMSwwLjQtMSwxdjJoLTIgYy0wLjYsMC0xLDAuNC0xLDF2M2gtNFY3YzAtMC42LTAuNC0xLTEtMWgtMlY0YzAtMC42LTAuNC0xLTEtMUg3QzYuNCwzLDYsMy40LDYsNHYzYzAsMC42LDAuNCwxLDEsMWgydjJIN2MtMC42LDAtMSwwLjQtMSwxdjJINCBjLTAuNiwwLTEsMC40LTEsMXYySDFjLTAuNiwwLTEsMC40LTEsMXY5YzAsMC42LDAuNCwxLDEsMWgzYzAuNiwwLDEtMC40LDEtMXYtNWgxdjVjMCwwLjYsMC40LDEsMSwxaDJ2MmMwLDAuNiwwLjQsMSwxLDFoNCBjMC42LDAsMS0wLjQsMS0xdi0zYzAtMC42LTAuNC0xLTEtMWgtM3YtMWgxMHYxaC0zYy0wLjYsMC0xLDAuNC0xLDF2M2MwLDAuNiwwLjQsMSwxLDFoNGMwLjYsMCwxLTAuNCwxLTF2LTJoMmMwLjYsMCwxLTAuNCwxLTF2LTUgaDF2NWMwLDAuNiwwLjQsMSwxLDFoM2MwLjYsMCwxLTAuNCwxLTF2LTlDMzIsMTYuNCwzMS42LDE2LDMxLDE2eiBNMTQsMTljMCwwLjYtMC40LDEtMSwxaC0zYy0wLjYsMC0xLTAuNC0xLTF2LTNjMC0wLjYsMC40LTEsMS0xIGgzYzAuNiwwLDEsMC40LDEsMVYxOXogTTIzLDE5YzAsMC42LTAuNCwxLTEsMWgtM2MtMC42LDAtMS0wLjQtMS0xdi0zYzAtMC42LDAuNC0xLDEtMWgzYzAuNiwwLDEsMC40LDEsMVYxOXoiLz4gPC9zdmc+IA==
