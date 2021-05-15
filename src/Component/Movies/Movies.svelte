<script>
    import { onMount } from "svelte";
    import SingleMovie from "./SingleMovie.svelte";
    let movies = [];

    onMount(async function () {
        if (localStorage.getItem("movies")) {
            movies = JSON.parse(localStorage.getItem("movies"));
            console.log(movies);
            return;
        }

        const response = await fetch(`${__lotr.env.API_URL}/movie`, {
            method: "GET",
            headers: {
                Authorization: `Bearer ${__lotr.env.API_TOKEN}`,
            },
        })
            .then((result) => result.json())
            .then((data) => {
                localStorage.setItem("movies", JSON.stringify(data.docs));
                return (movies = data.docs);
            });
    });
</script>

<section class="movies-section">
    <div class="background" />
    <h2>From the Hobbits saga to The Lord of the Rings trilogy</h2>

    {#if movies !== undefined}
        {#await movies}
            <p>Movies are loading</p>
        {:then movies}
            <div class="content">
                <div class="movies">
                    {#each movies as movie}
                        <SingleMovie {movie} />
                    {/each}
                </div>
            </div>
        {/await}
    {/if}
</section>

<style type="text/scss">
    .movies-section {
        position: relative;
        margin-top: 70px;
        .background {
            background-image: url("../assets/movie-background.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
            opacity: 0.2;
            filter: saturate(0.3);
        }
        h2{
            padding: 1rem 0;
            @media screen and (min-width: 576px)
            {
                padding: 2rem 0;
            }
            @media screen and (min-width: 768px) {
                padding: 3rem 0;
            }
        }
        .movies {
            display: grid;
            grid-gap: 2rem;
            grid-template-columns: repeat(1, minmax(0, 1fr));
            @media screen and (min-width: 768px) {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }
    }
</style>
