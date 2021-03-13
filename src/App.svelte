<script>
    import {Router, Link, Route} from "svelte-routing"
    import Books from "./Component/Books.svelte"
    import Movies from "./Component/Movies.svelte"
    import Quotes from "./Component/Quotes.svelte"
    import Characters from "./Component/Characters.svelte"
    export let url = '';
</script>

<Router url={url}>
    <header>
        <span><Link to="/">LotR - Svelte</Link></span>
        <nav>
            <Link to="/Books">Books</Link>
            <Link to="/Movies">Movies</Link>
            <Link to="/Quotes">Quotes</Link>
            <Link to="/Characters">Characters</Link>
        </nav>
    </header>

    <main>
        <div>
            <Route path="/Books">
                <Books/>
            </Route>
            <Route path="/Movies">
                <Movies/>
            </Route>
            <Route path="/Quotes">
                <Quotes/>
            </Route>
            <Route path="/Characters">
                <Characters/>
            </Route>
        </div>
    </main>
</Router>

<style type="text/scss">
    $orange : #ff3e00;
    header {
        width: 100%;
        justify-content: space-between;
        background-color: $orange;
        display: flex;
        nav, span {
            margin: 1rem 0;
            padding: 0 .75rem;
        }
        :global(a) {
            color:white;
            text-decoration: none;
            display: inline-block;
            &:after{
                content:'';
                width: 0;
                background-color: white;
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
        padding: 1em;
        max-width: 240px;
        margin: 0 auto;
    }
    @media (min-width: 640px){
        main{
            max-width: none;
        }
    }
</style>