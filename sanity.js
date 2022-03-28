import createImageUrlBuilder from '@sanity/image-url'
import {
    createCurrentUserHook,
    createClient,
} from "next-sanity";

export const config = {
    /**
     *  Find your project ID and dataset ID in sanity.json in your studio project.
     * These are considered public but you can use environment variables if you want
     * differ between local dev and production.
     */

    dataset: process.env.NEXT_PUBLIC_SANITY_DATASET || "production",
    projectId: process.env.NEXT_PUBLIC_SANITY_PROJECT_ID,
    apiVersion: "2021-03-25",
    /**
     * Set useCdn to `true` and you'll get the best performance, false if you want freshest possible data
     */
    useCdn: process.env.NODE_ENV === 'production',
};

export const sanityClient = createClient(config);

export const urlFor = (source) => createImageUrlBuilder(config).image(source);