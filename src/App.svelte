<script>
    import {Router, Link, Route} from "svelte-routing";
    import Books from "./Component/Books/Books.svelte";
    import Movies from "./Component/Movies/Movies.svelte";
    import Characters from "./Component/Characters/Characters.svelte";
    import Home from "./Component/Home/Home.svelte";
    export let url = '';
</script>

<Router url={url}>
    <header>
        <span><Link to="/">LotR</Link></span>
        <nav>
            <Link to="/Books">Books</Link>
            <Link to="/Movies">Movies</Link>
            <Link to="/Characters">Characters</Link>
        </nav>
    </header>

    <main>
        <div>
            <Route path="/">
                <Home/>
            </Route>
            <Route path="/Books">
                <Books/>
            </Route>
            <Route path="/Movies">
                <Movies/>
            </Route>
            <Route path="/Characters">
                <Characters/>
            </Route>
        </div>
    </main>
</Router>

<style type="text/scss">
    $gold : #C4B479;
    header {
        width: 100%;
        justify-content: space-between;
        background-color: black;
        display: flex;
        position: fixed;
        z-index: 50;
        nav, span {
            margin: 1rem 0;
            padding: 0 .75rem;
            &:first-child{
                font-size: 1.25em;
            }
        }
        :global(a) {
            color:$gold;
            text-decoration: none;
            display: inline-block;
            &:after{
                content:'';
                width: 0;
                background-color: $gold;
            }
            &:not(:first-child){
                margin-left: 1rem;
            }
            &[aria-current="page"]{
                position: relative;
                &:after{
                    display: block;
                    transition: width .5s ease-in-out;
                    width: 100%;
                    height: 2px;
                    border-radius: .5rem;
                    margin-top: .5rem;
                }
            }
        }
    }
    main {
        text-align: center;
        padding: 1rem;
        margin: 0 auto;
        position: relative;
        @media screen and (min-width: 768px) {
            padding: 1rem 1rem 2rem 1rem
        }
    }
</style>