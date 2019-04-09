
const fs = require('fs');
const jsdom = require("jsdom");
const { JSDOM } = jsdom;

const input = process.argv[2];
const output = process.argv[3];


const content = fs.readFileSync(input , 'utf8');

const { document } = (new JSDOM(content)).window;

const footNoteArray = document.getElementsByClassName('footnote');


for (var i=0; i<footNoteArray.length; i++){
    const footNote = footNoteArray[i];
    const cnt = i + 1;   
    // 本文中の脚注
    const hrefInBody = document.createElement('a');
    hrefInBody.setAttribute("href", "#fn" + cnt);
    hrefInBody.setAttribute("id", "fnref" + cnt);
    hrefInBody.setAttribute("class", "fnref");
    hrefInBody.textContent = " *" + cnt;
    footNote.parentNode.insertBefore(hrefInBody, footNote); 

    // 脚注のインデックス
    const href = document.createElement('a');
    href.setAttribute("href", "#fnref" + cnt);
    href.setAttribute("class", "fnref");
    href.textContent = "*" + cnt + " ";
    footNote.insertBefore(href, footNote.firstChild);
    footNote.setAttribute("id", "fn" + cnt);
}

fs.writeFileSync(output, document.documentElement.outerHTML);




