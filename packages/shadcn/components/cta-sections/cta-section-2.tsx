"use client";

import { Button } from "@/components/ui/button";

export function CtaSection2() {
  return (
    <section 
      className="bg-primary py-16 md:py-24"
      aria-labelledby="cta-heading"
    >
      <div className="container mx-auto px-6">
        <div className="w-full flex flex-col md:flex-row gap-8 items-center text-center md:text-left justify-between">
          {/* Main Title */}
          <h2 
            id="cta-heading"
            className="text-3xl md:text-4xl font-bold text-primary-foreground max-w-lg"
          >
            Action-driving headline that creates urgency
          </h2>
          {/* CTA Buttons */}
          <div className="flex flex-col md:flex-row gap-3 align-right">
            {/* Primary Button */}
            <Button 
              className="bg-primary-foreground hover:bg-primary-foreground/80 text-primary"
              aria-label="Get started with our service"
            >
              Get started
            </Button>
            {/* Secondary Button */}
            <Button 
              variant="ghost" 
              className="text-primary-foreground hover:text-primary-foreground hover:bg-primary-foreground/10"
              aria-label="Learn more about our service"
            >
              Learn more
            </Button>
          </div>
        </div>
      </div>
    </section>
  );
}
