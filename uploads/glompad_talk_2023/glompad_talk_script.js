const addFragmentClass = (el) => {el.classList.add('fragment')};

const fragmentize = () => {
    document.querySelectorAll(
        'li,p,pre,iframe,img:not(:first-child)'
        ).forEach(addFragmentClass);
    window.console.log('fragmentized');
}

setTimeout(fragmentize, 1500);
window.console.log('fragmentization scheduled');
