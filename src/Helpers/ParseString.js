class ParseString {

    removeUselessSpace(s){
        if (s[0] === ' ' && s[s.length - 1] === ' '){
           return s = s.slice(1,-1)
        }
    }

}

export default new ParseString();