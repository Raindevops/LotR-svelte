<script>
    import { onMount } from 'svelte';
    let books = [];

    onMount(async function(){
        if (localStorage.getItem("books")) {
            books = JSON.parse(localStorage.getItem("books"));
            return;
        }
    
        const response = await fetch("https://the-one-api.dev/v2/book");
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
                <p>{book.name}</p>
            {/each}
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>