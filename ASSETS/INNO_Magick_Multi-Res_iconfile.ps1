Set-Location C:\Users\Ben\Documents\GitHub\SCM_Charts\ASSETS\
<#
Creation of Charts PNG assets
NOTE: Square aspect ratio used for icons.
Includes - Windows universal platform package logos (PNG) 
#>
$inpath = 'C:\Users\Ben\Documents\GitHub\SCM_Charts\ASSETS\'
$infile = $inpath + 'SCM_Charts-800x800.png'

$outpath = 'C:\Users\Ben\Documents\GitHub\SCM_Charts\ASSETS\'
$outfileICO = $outpath + 'SCM_Charts.ico'
$outfileWUP150 = $outpath + 'SCM_Charts_150x150.png'
$outfileWUP44 = $outpath + 'SCM_Charts_44x44.png'

if (Test-Path -Path $outfileICO -PathType Leaf) {
    Remove-Item $outfileICO
}

magick convert $infile -flatten -resize 256x256 -alpha off -background white -define icon:auto-resize="256,128,96,64,48,32,16" $outfileICO

if (Test-Path -Path $outfileWUP150 -PathType Leaf) {
    Remove-Item $outfileWUP150
}

magick convert $infile -flatten -resize 150x150 $outfileWUP150

if (Test-Path -Path $outfileWUP44 -PathType Leaf) {
    Remove-Item $outfileWUP44
}

magick convert $infile -flatten -resize 44x44 $outfileWUP44
