<script>
    import { onMount } from "svelte";
    import SingleBook from "./SingleBook.svelte";
    let books = [];

    onMount(async function () {
        if (localStorage.getItem("books")) {
            books = JSON.parse(localStorage.getItem("books"));
            return;
        }

        const response = await fetch(`${__lotr.env.API_URL}/book`);
        const data = await response.json();
        books = data.docs;

        localStorage.setItem("books", JSON.stringify(books));
    });
</script>

<section class="books">
    <div class="background" />
    {#if books !== undefined}
        {#await books}
            <p>Loading</p>
        {:then books}
            {#each books as book}
                <SingleBook {book} />
            {/each}
        {/await}
    {/if}
</section>

<style type="text/scss">
    .books {
        position: relative;
        margin-top: 70px;
        .background {
            background-image: url("../assets/book-background.png");
            background-repeat: no-repeat;
            background-size: contain;
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
            animation: 1s ease-in-out fadeIn;
        }
        margin-top: 65px;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
</style>
