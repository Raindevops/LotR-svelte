<script>
    import { onMount } from 'svelte';
    import SingleBook from './SingleBook.svelte';
    let books = [];

    onMount(async function(){
        if (localStorage.getItem("books")) {
            books = JSON.parse(localStorage.getItem("books"));
            return;
        }
    
        const response = await fetch(`${__lotr.env.API_URL}/book`);
        const data = await response.json();
        books = data.docs

        localStorage.setItem("books", JSON.stringify(books));
    });

</script>

<main>
    <h1>Beyond Wonderland</h1>
    {#if books !== undefined}
        {#await books}
            <p>Loading</p>
            {:then books}
            {#each books as book}
                <SingleBook book={book}/>
            {/each}
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>