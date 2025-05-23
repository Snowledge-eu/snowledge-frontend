"use client";

import { Star } from "lucide-react";
import Image from "next/image";

export function TestimonialsSection3() {
  return (
    <section className="py-16 md:py-24 bg-muted/40">
      {/* Main Content Container */}
      <div className="container mx-auto px-6">
        {/* Two-Column Grid Layout */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 md:gap-16 items-center">
          {/* Testimonial Image */}
          <Image
            src="https://ui.shadcn.com/placeholder.svg"
            alt="Testimonial image"
            fill
            className="rounded-xl"
          />
          {/* Testimonial Content Wrapper */}
          <div className="flex flex-col items-center md:items-start gap-8">
            {/* Star Rating */}
            <div className="flex gap-1">
              {[...Array(5)].map((_, i) => (
                <Star
                  key={i}
                  className="w-6 h-6 fill-yellow-500 text-yellow-500"
                />
              ))}
            </div>

            {/* Testimonial Quote */}
            <blockquote className="text-lg lg:text-2xl font-medium text-center md:text-left text-foreground">
              &quot;We absolutely love how the Shadcn UI Kit blends
              functionality and aesthetics seamlessly. It fits perfectly into
              our design workflow and gives us the flexibility to create
              stunning, professional and high-quality designs
              effortlessly.&quot;
            </blockquote>

            {/* Author Information */}
            <div className="flex flex-col items-center md:items-start space-y-0.5">
              <span className="text-base font-semibold text-foreground">
                Lando Norris
              </span>
              <span className="text-base text-muted-foreground">
                CEO at Acme Inc.
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
